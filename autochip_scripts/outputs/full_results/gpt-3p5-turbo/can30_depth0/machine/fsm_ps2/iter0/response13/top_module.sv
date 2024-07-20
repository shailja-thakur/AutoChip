module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [1:0] state;
    reg done;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // BYTE1 state
            done <= 0;
        end else begin
            case (state)
                2'b00: begin // BYTE1 state
                    if (in[2] == 1'b1)
                        state <= 2'b01; // BYTE2 state
                end
                
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // BYTE3 state
                end
                
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // DONE state
                end
                
                2'b11: begin // DONE state
                    if (in[2] == 1'b0)
                        state <= 2'b00; // BYTE1 state
                    else
                        state <= 2'b01; // BYTE2 state
                    
                    done <= 1;
                end
            endcase
        end
    end
    
endmodule
