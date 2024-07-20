module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [3:0] state;
    reg done;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0001; // BYTE1
            done <= 0;
        end else begin
            case (state)
                4'b0001: begin // BYTE1
                    if (in[2] == 1'b1) begin
                        state <= 4'b0010; // BYTE2
                    end
                end
                4'b0010: begin // BYTE2
                    state <= 4'b0011; // BYTE3
                end
                4'b0011: begin // BYTE3
                    state <= 4'b0100; // DONE
                end
                4'b0100: begin // DONE
                    if (in[2] == 1'b0) begin
                        state <= 4'b0001; // BYTE1
                    end else begin
                        state <= 4'b0010; // BYTE2
                    end
                end
                default: begin
                    state <= 4'b0001; // DEFAULT to BYTE1
                end
            endcase
        end
    end
    
    assign done = (state == 4'b0100) ? 1'b1 : 1'b0;

endmodule
