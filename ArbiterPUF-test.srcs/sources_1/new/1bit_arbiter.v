module bit_arbiter(
    input wire CLK,
    input wire [3:0] SW,
    output wire response
);

    wire [3:0] delay_line_path0;
    wire [3:0] delay_line_path1;

    // Selector モジュールのインスタンス化
    selector u1 (
        .in0(CLK),
        .in1(CLK),
        .challenge(SW[0]),
        .out0(delay_line_path0[0]),
        .out1(delay_line_path1[0])
    );
    selector u2 (
        .in0(delay_line_path0[0]),
        .in1(delay_line_path1[0]),
        .challenge(SW[1]),
        .out0(delay_line_path0[1]),
        .out1(delay_line_path1[1])
    );
    selector u3 (
        .in0(delay_line_path0[1]),
        .in1(delay_line_path1[1]),
        .challenge(SW[2]),
        .out0(delay_line_path0[2]),
        .out1(delay_line_path1[2])
    );
    selector u4 (
        .in0(delay_line_path0[2]),
        .in1(delay_line_path1[2]),
        .challenge(SW[3]),
        .out0(delay_line_path0[3]),
        .out1(delay_line_path1[3])
    );

    wire [1:0] arbiter_input;
    assign arbiter_input[0] = delay_line_path0[3];
    assign arbiter_input[1] = delay_line_path1[3];
    
    decision d1 (
        .in(arbiter_input),
        .response(response)
    );
endmodule
