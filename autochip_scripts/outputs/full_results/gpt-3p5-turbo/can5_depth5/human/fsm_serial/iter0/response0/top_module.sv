module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    reg [3:0] state;
    reg start_bit_detected;
    reg [7:0] data_bits;
    reg stop_bit_detected;
    
    // Internal signals
    
    reg [2:0] bit_counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_bit_detected <= 1'b0;
            data_bits <= 8'b0;
            stop_bit_detected <= 1'b0;
        end else begin
            case (state)
                4'b0000: // Idle state
                    begin
                        if (in == 1'b0) begin
                            state <= 4'b0001;
                        end
                    end
                4'b0001: // Start bit detected
                    begin
                        state <= 4'b0010;
                        start_bit_detected <= 1'b1;
                        bit_counter <= 3'b000;
                        data_bits <= in;
                    end
                4'b0010: // Data bit received
                    begin
                        if (bit_counter == 3'b111) begin
                            state <= 4'b0011;
                            data_bits[7:1] <= data_bits[6:0];
                            data_bits[0] <= in;
                        end else begin
                            state <= 4'b0010;
                            bit_counter <= bit_counter + 1'b1;
                            data_bits[7:1] <= data_bits[6:0];
                            data_bits[0] <= in;
                        end
                    end
                4'b0011: // Stop bit detected
                    begin
                        if (in == 1'b1) begin
                            state <= 4'b0000;
                            stop_bit_detected <= 1'b1;
                        end else begin
                            state <= 4'b0100;
                        end
                    end
                4'b0100: // Waiting for stop bit
                    begin
                        if(in == 1'b1) begin
                            state <= 4'b0000;
                            stop_bit_detected <= 1'b1;
                        end
                    end
            endcase
        end
    end
    
    assign done = stop_bit_detected;
    
endmodule
