module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    
    reg [2:0] state;
    reg flag;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            flag <= 1;  // Set flag to 1 to discard bytes until a message boundary is detected
        end else begin
            case (state)
                0: begin
                    if (in[3]) begin
                        state <= 1;
                        flag <= 0; // Set flag to 0 to start receiving bytes
                    end else begin
                        flag <= 1; // Set flag to 1 to discard current byte
                    end
                end
                1: begin
                    if (flag) begin
                        state <= 0;
                    end else if (in[3]) begin
                        state <= 2;
                    end else begin
                        state <= 1;
                    end
                end
                2: begin
                    if (flag) begin
                        state <= 0;
                    end else if (in[3]) begin
                        state <= 3;
                    end else begin
                        state <= 1;
                    end
                end
                3: begin
                    if (flag) begin
                        state <= 0;
                    end else if (in[3]) begin
                        done <= 1; // Set done signal high to indicate receipt of a message
                        state <= 0;
                    end else begin
                        state <= 1;
                    end
                end
            endcase
        end
    end
    
endmodule
