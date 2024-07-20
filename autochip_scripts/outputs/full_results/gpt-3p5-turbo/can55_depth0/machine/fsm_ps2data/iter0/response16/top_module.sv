module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state;
    wire bit3 = in[2];
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Initial state is BYTE1
            out_bytes <= 0;
            done <= 0;
        end
        else begin
            case (state)
                2'b00: begin // BYTE1
                    if (bit3) begin
                        state <= 2'b01; // Transition to BYTE2
                    end
                    else begin
                        state <= 2'b00; // Stay in BYTE1
                    end
                end
                2'b01: begin // BYTE2
                    state <= 2'b10; // Transition to BYTE3
                end
                2'b10: begin // BYTE3
                    state <= 2'b11; // Transition to DONE
                end
                2'b11: begin // DONE
                    if (bit3) begin
                        state <= 2'b00; // Transition to BYTE1
                    end
                    else begin
                        state <= 2'b00; // Transition to BYTE1
                    end
                end
                default: begin
                    state <= 2'b00; // Default to BYTE1
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (done) begin
            out_bytes <= out_bytes; // No change
        end
        else begin
            out_bytes <= {out_bytes[15:0], in}; // Shift register left and update with input
        end
    end
    
    always @(posedge clk) begin
        if (state == 2'b11) begin
            done <= 1; // Set done signal when in DONE state
        end
        else begin
            done <= 0;
        end
    end
endmodule
