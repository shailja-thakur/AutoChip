module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        3'b000: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b001: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b100;
            end
        end
        3'b010: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b011: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b010;
            end
        end
        3'b100: begin
            if (x == 1'b0) begin
                next_state = 3'b011;
            end else begin
                next_state = 3'b100;
            end
        end
        default: begin
            next_state = 3'b000;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        3'b011, 3'b100: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

// State update logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

endmodule
