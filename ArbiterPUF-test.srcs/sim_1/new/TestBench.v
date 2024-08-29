`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/21 10:56:28
// Design Name: 
// Module Name: TestBench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TestBench;

    // テストベンチ用の信号定義
    reg CLK;
    reg [15:0] SW;
    wire [3:0] LD;

    // テスト対象のモジュールインスタンス
    Arbiter_PUF uut (
        .CLK(CLK),
        .SW(SW),
        .LD(LD)
    );

    // クロック生成
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // 50MHzのクロック周期
    end

    // テストシーケンス
    initial begin
        // 初期化
        SW = 16'b0000000000000000;

        // ステップ1: 初期状態での出力確認
        #100;
//        $display("Time: %0t | SW: %b | LD: %b", $time, SW, LD);

        // ステップ2: SW の値を変更
        SW = 16'b1111000011110000;
        #100;
//        $display("Time: %0t | SW: %b | LD: %b", $time, SW, LD);

        // ステップ3: 別の SW の値を設定
        SW = 16'b0101010101010101;
        #100;
//        $display("Time: %0t | SW: %b | LD: %b", $time, SW, LD);

        // ステップ4: 更に別の SW の値を設定
        SW = 16'b1010101010101010;
        #100;
//        $display("Time: %0t | SW: %b | LD: %b", $time, SW, LD);

        // シミュレーション終了
        $stop;
    end

endmodule

