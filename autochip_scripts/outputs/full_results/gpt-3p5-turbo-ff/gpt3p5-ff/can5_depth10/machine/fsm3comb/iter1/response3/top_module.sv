module top_module (
    input wire clk,
    input wire in,
    input wire [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always_comb begin
        case(state)
            2'b00:
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            2'b01:
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
            2'b10:
                if (in)
                    next_state = 2'b11;
                else
                    next_state = 2'b00;
            2'b11:
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
        endcase
    end

    always @(posedge clk) begin
        if (state == 2'b11)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
