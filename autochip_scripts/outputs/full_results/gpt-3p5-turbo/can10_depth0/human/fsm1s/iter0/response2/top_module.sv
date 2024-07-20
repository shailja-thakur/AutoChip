module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b10;  // reset state B
        end else begin
            case(state)
                2'b10: begin  // B state
                    if (in) begin
                        state <= 2'b10;  // remain in B state
                        out <= 1'b1;
                    end else begin
                        state <= 2'b01;  // move to A state
                        out <= 1'b1;
                    end
                end
                2'b01: begin  // A state
                    if (in) begin
                        state <= 2'b01;  // remain in A state
                        out <= 1'b0;
                    end else begin
                        state <= 2'b10;  // move to B state
                        out <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
