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

    always @(posedge clk) begin
        if (reset) begin
            received_data <= 8'b0;
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (start_bit) begin
                        state <= 3'b001;
                    end
                end
                3'b001: begin // Receiving data bits
                    received_data <= {in, received_data[7:1]};
                    if (state == 3'b111) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b010;
                    end
                end
                3'b010: begin // Waiting for start bit
                    if (start_bit) begin
                        state <= 3'b001;
                    end
                end
                3'b011: begin // Receiving start bit
                    state <= 3'b010;
                end
                3'b100: begin // Waiting for stop bit
                    if (stop_bit) begin
                        state <= 3'b000;
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end
endmodule
