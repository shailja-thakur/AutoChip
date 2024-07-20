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
    wire start_bit = (state == 3'b000) ? 1'b1 : 1'b0;
    wire stop_bit = (state == 3'b100) ? 1'b1 : 1'b0;
    
    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            received_data <= 8'b0;
        end else begin
            received_data <= (state == 3'b011) ? {in, received_data[6:0]} : received_data;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            3'b000: begin // Idle state
                if (start_bit) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b000;
                end
            end
            3'b001: begin // Receiving data bits
                if (state == 3'b111) begin
                    next_state = 3'b100;
                end else begin
                    next_state = 3'b010;
                end
            end
            3'b010: begin // Waiting for start bit
                if (start_bit) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b010;
                end
            end
            3'b011: begin // Receiving start bit
                next_state = 3'b010;
            end
            3'b100: begin // Waiting for stop bit
                if (stop_bit) begin
                    next_state = 3'b000;
                end else begin
                    next_state = 3'b100;
                end
            end
            default: next_state = 3'b000;
        endcase
    end
endmodule
