`timescale 1ns / 1ps
module Arbiter_PUF(
    input CLK,
    input BTN,
    input [15:0] SW,
    output [3:0] LD,
    output LED

);
    reg [31:0] counter;         // クロックカウント用レジスタ
    wire [3:0] response;         // レスポンス信号
//    reg [3:0] rsp = 0;
    reg update_response;        // レスポンス更新フラグ
    wire [25:0] challenge;
    
    assign challenge = SW;
//    reg test_led = 0;
    // クロックカウント
    always @(posedge CLK) begin
        if (counter >= 32'd50000000 - 1) begin // 50MHzクロックで1秒カウント
            counter <= 0;
            update_response <= ~update_response; // 1秒ごとにレスポンスを更新
//            test_led <= ~test_led;
        end else begin
            counter <= counter + 1;
//            update_response <= 0;
        end
    end

    // bit_arbiter モジュールのインスタンス化とレスポンスの更新
    bit_arbiter inst1 (
        .CLK(BTN),
        .SW(challenge[3:0]),
        .response(response[0])
    );
    bit_arbiter inst2 (
        .CLK(BTN),
        .SW(challenge[7:4]),
        .response(response[1])
    );
    bit_arbiter inst3 (
        .CLK(BTN),
        .SW(challenge[11:8]),
        .response(response[2])
    );
    bit_arbiter inst4 (
        .CLK(BTN),
        .SW(challenge[15:12]),
        .response(response[3])
    );

    assign LD[3:0] = response[3:0];
    assign LED = update_response;
endmodule