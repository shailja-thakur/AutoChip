module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == S4)
            start_shifting <= 1;
    end
end

always @(*) begin
    case (state)
        S0: begin
            if (data == 1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (data == 0)
                next_state = S2;
            else
                next_state = S0;
        end
        S2: begin
            if (data == 1)
                next_state = S3;
            else
                next_state = S0;
        end
        S3: begin
            if (data == 1)
                next_state = S4;
            else
                next_state = S0;
        end
        S4: begin
            next_state = S4;
        end
        default: next_state = S0;
    endcase
end

endmodule
