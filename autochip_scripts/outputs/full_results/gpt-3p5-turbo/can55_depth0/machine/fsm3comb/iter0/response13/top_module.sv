module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
   
    always_comb begin
        case (state)
            2'b00: begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
            end
            2'b10: begin
                if (in)
                    next_state = 2'b11;
                else
                    next_state = 2'b00;
            end
            2'b11: begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
            end
        endcase
    end

    always @(posedge clk) begin
        case (state)
            2'b11: begin
                if (in)
                    out <= 1'b1;
                else
                    out <= 1'b0;
            end
            default: out <= 1'b0;
        endcase
    end

endmodule
