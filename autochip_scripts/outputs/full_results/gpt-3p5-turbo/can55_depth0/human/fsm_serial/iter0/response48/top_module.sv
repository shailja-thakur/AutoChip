module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] data;
    reg valid_data;
    reg start_bit_detected;
    reg stop_bit_detected;
    
    parameter START_BIT = 0;
    parameter STOP_BIT = 1;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            data <= 8'b0;
            valid_data <= 1'b0;
            start_bit_detected <= 1'b0;
            stop_bit_detected <= 1'b0;
        end
        else begin
            case(state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        start_bit_detected <= 1'b1;
                        state <= 3'b001;
                    end
                end
                3'b001: begin // Start bit detected, receiving data bits
                    data <= {in, data[7:1]};
                    state <= 3'b010;
                end
                3'b010: begin // Continue receiving data bits
                    data <= {in, data[7:1]};
                    if (start_bit_detected == 1'b0) begin
                        if (stop_bit_detected == 1'b0) begin
                            if (in == STOP_BIT) begin
                                valid_data <= 1'b1;
                                state <= 3'b011;
                            end
                            else
                                stop_bit_detected <= 1'b1;
                        end
                        else
                            stop_bit_detected <= 1'b0;
                    end
                    else
                        start_bit_detected <= 1'b0;
                end
                3'b011: begin // Stop bit detected, byte received
                    if (in == 1'b1) begin
                        valid_data <= 1'b0;
                        done <= 1'b1;
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end

endmodule
