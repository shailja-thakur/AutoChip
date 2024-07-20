module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [0:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // Asynchronously reset to state B
            out <= 1'b1;
        end
        else begin
            case (state)
                1'b0: begin // State A
                    if (in) begin
                        state <= 1'b0;
                        out <= 1'b0;
                    end
                    else begin
                        state <= 1'b1;
                        out <= 1'b0;
                    end
                end
                1'b1: begin // State B
                    if (in) begin
                        state <= 1'b1;
                        out <= 1'b1;
                    end
                    else begin
                        state <= 1'b0;
                        out <= 1'b1;
                    end
                end
            endcase
        end
    end

endmodule
