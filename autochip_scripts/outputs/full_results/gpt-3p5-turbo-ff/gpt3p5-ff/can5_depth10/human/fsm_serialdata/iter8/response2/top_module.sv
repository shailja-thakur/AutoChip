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
  
    // Internal signals
    wire start_bit_detected = (state == 3'b000) ? in : 1'b0;
    wire stop_bit_detected = (state == 3'b100) ? in : 1'b0;
  
    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit_detected;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            received_data <= 8'b0;
        end else begin
            state <= next_state;
            received_data <= (state == 3'b011) ? {in, received_data[7:1]} : received_data;
        end
    end
  
    always @* begin
        case (state)
            3'b000: begin // Idle state
                next_state = (start_bit_detected) ? 3'b001 : 3'b000;
            end
            3'b001: begin // Receiving data bits
                next_state = (state == 3'b111) ? 3'b100 : {state[1:0], 1'b0};
            end
            3'b010: begin // Waiting for start bit
                next_state = (start_bit_detected) ? 3'b001 : 3'b010;
            end
            3'b011: begin // Receiving start bit
                next_state = 3'b010;
            end
            3'b100: begin // Waiting for stop bit
                next_state = (stop_bit_detected) ? 3'b000 : 3'b100;
            end
            default: next_state = 3'b000;
        endcase
    end
endmodule
