module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        S0: begin
            if (data == 1'b0) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
            start_shifting = 1'b0;
        end
        S1: begin
            if (data == 1'b1) begin
                next_state = S2;
            end
            else begin
                next_state = S0;
            end
            start_shifting = 1'b0;
        end
        S2: begin
            if (data == 1'b0) begin
                next_state = S3;
            end
            else begin
                next_state = S0;
            end
            start_shifting = 1'b0;
        end
        S3: begin
            if (data == 1'b1) begin
                next_state = S4;
            end
            else begin
                next_state = S0;
            end
            start_shifting = 1'b0;
        end
        S4: begin
            next_state = S4;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = S0;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
