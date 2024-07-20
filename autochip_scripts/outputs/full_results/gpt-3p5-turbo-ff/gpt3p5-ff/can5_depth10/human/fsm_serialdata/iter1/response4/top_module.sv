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
    reg start_bit;
    reg stop_bit;
    
    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            received_data <= 8'b0;
        end else begin
            received_data <= in;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            start_bit <= 1'b0;
            stop_bit <= 1'b0;
        end else begin
            state <= next_state;
            start_bit <= (state == 3'b000) ? in : 1'b0;
            stop_bit <= (state == 3'b100) ? in : 1'b0;
        end
    end
    
    always @* begin
        case (state)
            3'b000: begin // Idle state
                next_state = (start_bit) ? 3'b001 : 3'b000;
            end
            3'b001: begin // Receiving data bits
                next_state = (state == 3'b111) ? 3'b100 : 3'b010;
            end
            3'b010: begin // Waiting for start bit
                next_state = (start_bit) ? 3'b001 : 3'b010;
            end
            3'b011: begin // Receiving start bit
                next_state = 3'b010;
            end
            3'b100: begin // Waiting for stop bit
                next_state = (stop_bit) ? 3'b000 : 3'b100;
            end
            default: next_state = 3'b000;
        endcase
    end
endmodule
