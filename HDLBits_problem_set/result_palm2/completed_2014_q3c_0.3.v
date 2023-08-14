module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    reg [2:0] state;
    reg z;

    always @(posedge clk) begin
        case (x)
            0: state <= y;
            1: state <= (y + 1) mod 4;
        endcase

        case (state)
            000: z <= 0;
            001: z <= 1;
            010: z <= 0;
            011: z <= 1;
            100: z <= 1;
        endcase

        Y0 <= state[0];
    end

endmodule