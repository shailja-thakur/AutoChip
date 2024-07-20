module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg start_bit_found;
reg [7:0] data_bits;
reg stop_bit_found;

assign done = (state == 4);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        start_bit_found <= 0;
        data_bits <= 0;
        stop_bit_found <= 0;
    end else begin
        case (state)
            0: begin
                if (in == 0) begin
                    state <= 1;
                    start_bit_found <= 1;
                end
            end
            1: begin
                data_bits <= {data_bits[6:0], in};
                state <= 2;
            end
            2: begin
                data_bits <= {data_bits[6:0], in};
                state <= 3;
            end
            3: begin
                data_bits <= {data_bits[6:0], in};
                state <= 4;
            end
            4: begin
                if (in == 1) begin
                    stop_bit_found <= 1;
                end
                state <= 0;
            end
        endcase
    end
end

endmodule
