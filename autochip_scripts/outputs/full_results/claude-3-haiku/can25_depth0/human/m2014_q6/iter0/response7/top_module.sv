module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State encoding
localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam D = 3'b011;
localparam E = 3'b100;
localparam F = 3'b101;

reg [2:0] curr_state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        curr_state <= A;
    end
    else begin
        curr_state <= next_state;
    end
end

always @(*) begin
    case (curr_state)
        A: begin
            if (w) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
            z = 0;
        end
        B: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
            z = 0;
        end
        C: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
            z = 0;
        end
        D: begin
            if (w) begin
                next_state = A;
            end
            else begin
                next_state = F;
            end
            z = 0;
        end
        E: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
            z = 1;
        end
        F: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
            z = 1;
        end
        default: begin
            next_state = A;
            z = 0;
        end
    endcase
end

endmodule
