module fsm_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            out_bytes <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin // BYTE1
                    if (in[2]) begin
                        state <= 1; // transition to BYTE2
                    end else begin
                        state <= 0; // stay in BYTE1
                    end
                end
                
                1: begin // BYTE2
                    if (in[2]) begin
                        state <= 2; // transition to BYTE3
                    end else begin
                        state <= 0; // transition to BYTE1
                    end
                end
                
                2: begin // BYTE3
                    state <= 3; // transition to DONE
                end
                
                3: begin // DONE
                    state <= 0; // transition to BYTE1
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (!reset) begin
            case (state)
                0: begin // BYTE1
                    out_bytes <= {in, out_bytes[23:8]};
                end
                    
                3: begin // DONE
                    out_bytes <= out_bytes;
                end
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3) begin
            done <= 1; // DONE state
        end else begin
            done <= 0;
        end
    end
    
endmodule
