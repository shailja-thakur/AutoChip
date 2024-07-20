module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 2'b01;
parameter B = 2'b10;

reg [1:0] state, next_state;

// State register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        B: begin
            if (x == 1'b0) begin
                next_state = B;
            end
            else begin
                next_state = B;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0) begin
                z = 1'b0;
            end
            else begin
                z = 1'b1;
            end
        end
        B: begin
            if (x == 1'b0) begin
                z = 1'b1;
            end
            else begin
                z = 1'b0;
            end
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
