module selector(
    input wire in0,
    input wire in1,
    input wire challenge,
    output wire out0,
    output wire out1
);
    assign out0 = (challenge == 0) ? in0 : in1;
    assign out1 = (challenge == 0) ? in1 : in0;
endmodule