module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] rx_data;
    reg start_bit_detected;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            rx_data <= 8'h00;
            start_bit_detected <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        start_bit_detected <= 1'b1;
                        state <= 3'b001;
                    end
                end
                3'b001: begin // Data bits receiving state
                    rx_data <= {rx_data[6:0], in};
                    state <= 3'b010;
                end
                3'b010: begin // Stop bit receiving state
                    if (in == 1'b1) begin
                        state <= 3'b011;
                    end
                end
                3'b011: begin // Byte received state
                    done <= 1'b1;
                    state <= 3'b000;
                end
            endcase
        end
    end

endmodule
