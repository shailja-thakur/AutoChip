module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State definitions
localparam A = 2'd0;
localparam B = 2'd1;
localparam C = 2'd2;
localparam D = 2'd3;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (in == 1'b0) begin
                next_state = A;
            end else begin
                next_state = B;
            end
            out = 1'b0;
        end
        B: begin
            if (in == 1'b0) begin
                next_state = C;
            end else begin
                next_state = B;
            end
            out = 1'b0;
        end
        C: begin
            if (in == 1'b0) begin
                next_state = A;
            end else begin
                next_state = D;
            end
            out = 1'b0;
        end
        D: begin
            if (in == 1'b0) begin
                next_state = C;
            end else begin
                next_state = B;
            end
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

// State register
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

endmodule
