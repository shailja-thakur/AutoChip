module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state, next_state;
    reg out_reg;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            2'b00: begin
                next_state = in ? 2'b10 : 2'b01;
                out_reg = 1'b0;
            end
            2'b01: begin
                next_state = in ? 2'b10 : 2'b01;
                out_reg = 1'b0;
            end
            2'b10: begin
                next_state = in ? 2'b00 : 2'b11;
                out_reg = 1'b0;
            end
            2'b11: begin
                next_state = in ? 2'b10 : 2'b01;
                out_reg = 1'b1;
            end
        endcase
    end

    always @(posedge clk) begin
        out <= out_reg;
    end

endmodule
