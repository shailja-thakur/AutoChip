module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    wire E;
    wire F;

    assign E = (state == 3'b011);
    assign F = (state == 3'b10);

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b00;
        end 
        else begin
            case ({state, w})
                3'b0000: state <= 3'b00;
                3'b0001: state <= 3'b01;
                3'b0010: state <= 3'b10;
                3'b0011: state <= 3'b01;
                3'b0100: state <= 3'b00;
                3'b0101: state <= 3'b10;
                3'b0110: state <= 3'b10;
                3'b0111: state <= 3'b01;
                3'b1000: state <= 3'b00;
                3'b1001: state <= 3'b11;
                3'b1010: state <= 3'b11;
                3'b1011: state <= 3'b11;
                3'b1100: state <= 3'b10;
                3'b1101: state <= 3'b10;
                3'b1110: state <= 3'b10;
                3'b1111: state <= 3'b01;
                default: state <= 3'b00;
            endcase
        end
    end

    assign z = (state == 3'b011) || (state == 3'b10);

endmodule
