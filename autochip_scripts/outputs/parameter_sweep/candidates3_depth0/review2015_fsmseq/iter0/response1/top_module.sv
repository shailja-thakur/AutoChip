module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
    );


reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        start_shifting <= 0;
    end else begin
        case(state)
            2'b00: begin
                if (data) state <= 2'b01;
                else state <= 2'b00;
            end
            2'b01: begin
                if (data) state <= 2'b10;
                else state <= 2'b00;
            end
            2'b10: begin
                if (data) state <= 2'b11;
                else state <= 2'b00;
            end
            2'b11: begin
                if (data) begin
                    state <= 2'b11;
                    start_shifting <= 1;
                end else begin
                    state <= 2'b00;
                    start_shifting <= 0;
                end
            end
            default: state <= 2'b00;
        endcase
    end
end

endmodule
