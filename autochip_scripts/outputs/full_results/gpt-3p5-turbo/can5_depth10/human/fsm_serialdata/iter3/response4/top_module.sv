module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [3:0] next_state;
    reg [2:0] counter;
    reg [7:0] rx_data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            counter <= 3'b000;
            rx_data <= 8'b0;
        end else begin
            state <= next_state;
            case (state)
                4'b0000: begin
                    if (in == 1'b0) begin
                        next_state <= 4'b0001;
                        counter <= 3'b000;
                        rx_data <= 8'b0;
                    end else begin
                        next_state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    next_state <= 4'b0010;
                    counter <= 3'b000;
                    rx_data <= in;
                end
                4'b0010: begin
                    if (counter == 3'b111) begin
                        next_state <= 4'b0011;
                        counter <= 3'b000;
                        rx_data <= in;
                    end else begin
                        next_state <= 4'b0010;
                        counter <= counter + 1;
                        rx_data <= {rx_data[6:0], in};
                    end
                end
                4'b0011: begin
                    next_state <= 4'b0000;
                    counter <= 3'b000;
                    rx_data <= 8'b0;
                    if (in == 1'b1) begin
                        out_byte <= rx_data;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end
                default: next_state <= 4'b0000;
            endcase
        end
    end

endmodule
