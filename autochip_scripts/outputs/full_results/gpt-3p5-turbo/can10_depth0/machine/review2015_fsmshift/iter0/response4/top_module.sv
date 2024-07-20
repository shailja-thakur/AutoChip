module top_module(
    input clk,
    input reset,
    output reg shift_ena);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset == 1) begin
            state <= 3'b0;
        end else begin
            case (state)
                3'b0: begin
                    if (shift_ena == 1) begin
                        state <= 3'b1;
                    end
                end
                3'b1: begin
                    if (shift_ena == 1) begin
                        state <= 3'b2;
                    end
                end
                3'b2: begin
                    if (shift_ena == 1) begin
                        state <= 3'b3;
                    end
                end
                3'b3: begin
                    if (shift_ena == 1) begin
                        state <= 3'bDone;
                    end
                end
                default: begin
                    state <= 3'bDone;
                end
            endcase
        end
    end
endmodule
