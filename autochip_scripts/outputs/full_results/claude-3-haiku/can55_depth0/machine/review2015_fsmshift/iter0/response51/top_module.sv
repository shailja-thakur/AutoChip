module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [2:0] state;
parameter B0 = 3'b000, B1 = 3'b001, B2 = 3'b010, B3 = 3'b011, DONE = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= B0;
    end
    else begin
        case (state)
            B0: state <= B1;
            B1: state <= B2;
            B2: state <= B3;
            B3: state <= DONE;
            DONE: state <= DONE;
            default: state <= B0;
        endcase
    end
end

always @(*) begin
    shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);
end

endmodule
