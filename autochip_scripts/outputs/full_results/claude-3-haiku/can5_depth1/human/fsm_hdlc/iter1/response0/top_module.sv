module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        S0: begin
            if (in == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
        S1: begin
            if (in == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S2;
            end
        end
        S2: begin
            if (in == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S3;
            end
        end
        S3: begin
            if (in == 1'b0) begin
                next_state = S0;
                disc = 1'b1;
            end
            else begin
                next_state = S4;
            end
        end
        S4: begin
            if (in == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S5;
                flag = 1'b1;
            end
        end
        S5: begin
            if (in == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S5;
                err = 1'b1;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
