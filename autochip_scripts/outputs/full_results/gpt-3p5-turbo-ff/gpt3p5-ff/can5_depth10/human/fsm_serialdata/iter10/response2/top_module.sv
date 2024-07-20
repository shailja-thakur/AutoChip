module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [7:0] received_data;
    reg [2:0] state;
    reg [2:0] next_state;
  
    // Internal signals
    wire start_bit = (state == 3'b000) ? 1'b0 : 1'b1;
    wire stop_bit = (state == 3'b100) ? 1'b1 : 1'b0;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            received_data <= 8'b0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;
            case (state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        next_state = 3'b001; // Transition to Receive state
                    end else begin
                        next_state = 3'b000; // Remain in Idle state
                    end
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in};
                    if (state == 3'b111) begin // All data bits received
                        next_state = 3'b010; // Transition to Stop state
                    end else begin
                        next_state = 3'b001; // Remain in Receive state
                    end
                end
                3'b010: begin // Waiting for stop bit
                    if (in == 1'b1) begin
                        next_state = 3'b100; // Transition to Done state
                    end else begin
                        next_state = 3'b010; // Remain in Waiting state
                    end
                end
                3'b100: begin // Done state
                    if (in == 1'b1) begin
                        next_state = 3'b000; // Transition back to Idle state
                    end else begin
                        next_state = 3'b100; // Remain in Done state
                    end
                    out_byte <= received_data;
                    done <= 1; // Output done signal
                end
            endcase
        end
    end
endmodule
