module top_module(
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg start_bit_detected;
    reg [7:0] data_reg;
    reg stop_bit_detected;
    reg done_reg;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 3'b000;
            start_bit_detected <= 0;
            data_reg <= 8'b00000000;
            stop_bit_detected <= 0;
            done_reg <= 0;
        end else begin
            case(state)
                3'b000: begin // Idle
                    if(in == 1'b1) begin
                        state <= 3'b001; // Start bit detected
                        start_bit_detected <= 1;
                    end
                end
                3'b001: begin // Data bits
                    data_reg <= {data_reg[6:0], in}; // Append the received bit to the data_reg
                    state <= 3'b010; // Move to the next state
                end
                3'b010: begin // Stop bit
                    if(in == 1'b0) begin
                        stop_bit_detected <= 1;
                        if(data_reg == 8'b00000000) begin
                            done_reg <= 1; // The received byte is all zero, set done
                        end
                    end
                    state <= 3'b100; // Wait for next idle bit
                end
                3'b100: begin // Wait for idle bit
                    if(in == 1'b1) begin
                        state <= 3'b000; // Move to the idle state
                        done_reg <= 0; // Clear done, ready to receive the next byte
                    end
                end
                default: begin
                    state <= 3'b000; // Default to idle state
                    done_reg <= 0; // Clear done, ready to receive the next byte
                end
            endcase
        end
    end

    assign done = done_reg;

endmodule
