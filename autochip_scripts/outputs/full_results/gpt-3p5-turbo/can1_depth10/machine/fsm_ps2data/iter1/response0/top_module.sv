module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] out_reg;
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            out_reg <= 0;
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
                    state <= 2; // transition to BYTE3
                end
                
                2: begin // BYTE3
                    state <= 3; // transition to DONE
                end
                
                3: begin // DONE
                    if (in[2]) begin
                        state <= 0; // transition to BYTE1
                    else begin
                        state <= 0; // transition to BYTE1
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (!reset) begin
            if (state == 0) begin // BYTE1
                out_reg <= {in, out_reg[23:8]};
            end elseif (state == 3) begin // DONE
                out_bytes <= out_reg;
            end
        end
    end
    
    assign done = (state == 3); // DONE state
    
endmodule
