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
    wire start_bit = (state == 3'b000) ? 1'b1 : 1'b0;
    wire stop_bit = (state == 3'b010) ? 1'b1 : 1'b0;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            received_data <= 0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (start_bit) begin
                        state <= 3'b001;
                        received_data <= 0;
                    end else begin
                        state <= 3'b000;
                        received_data <= 0;
                    end
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in};
                    if (state == 3'b111) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b010: begin // Waiting for stop bit
                    if (stop_bit) begin
                        state <= 3'b000;
                        out_byte <= received_data;
                        done <= 1'b1;
                        received_data <= 0;
                    end else begin
                        state <= 3'b010;
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end
endmodule
