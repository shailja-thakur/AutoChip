module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] received_data;
    reg [2:0] state;
    reg [2:0] next_state;
    reg start_bit_detected;
  
    // Internal signals
    wire stop_bit_detected = (state == 3'b100) ? 1'b1 : 1'b0;
  
    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit_detected;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            start_bit_detected <= 1'b0;
            received_data <= 8'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // Start bit detected
                        start_bit_detected <= 1'b1;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in};
                    if ((state == 3'b101) && (in == 1'b1)) begin
                        state <= 3'b010; // Stop bit detected
                    end else if (state == 3'b101) begin
                        state <= 3'b000; // Incorrect stop bit, wait for next start bit
                    end else begin
                        state <= (state == 3'b101) ? 3'b010 : 3'b001;
                    end
                end
                3'b010: begin // Waiting for stop bit
                    if (in == 1'b1) begin
                        state <= 3'b100; // Stop bit detected
                    end else begin
                        state <= 3'b010;
                    end
                end
                3'b100: begin // Waiting for next start bit
                    if (in == 1'b0) begin
                        state <= 3'b001; // Start bit detected
                        start_bit_detected <= 1'b1;
                    end else begin
                        state <= 3'b100;
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end
endmodule
