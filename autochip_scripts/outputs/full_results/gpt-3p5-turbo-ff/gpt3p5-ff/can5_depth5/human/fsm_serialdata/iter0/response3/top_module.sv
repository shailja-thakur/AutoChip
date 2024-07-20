module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [2:0] state;
    reg [7:0] data_byte;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b0;
        else begin
            case(state)
                // Idle state, waiting for start bit
                3'b000: begin
                    if (in == 1'b0)
                        state <= 3'b001;
                end
                // Receiving data bits
                3'b001, 3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111: begin
                    state <= state + 3'b001;
                    data_byte <= {data_byte[6:0], in};
                end
                // Verifying stop bit
                3'b1111: begin
                    if (in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end

endmodule
