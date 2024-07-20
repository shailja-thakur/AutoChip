module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [1:0] state, next_state;
    reg [1:0] w_count;

    parameter A = 2'd0, B = 2'd1, B1 = 2'd2, B2 = 2'd3;

    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            A: if (s) next_state = B;
            B: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B;  // Return to B to continue checking w
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            w_count <= 2'd0;
            z <= 1'b0;
        end
        else if (state == A) begin
            w_count <= 2'd0;
            z <= 1'b0;
        end
        else begin
            if (state == B || state == B1 || state == B2) begin
                if (w) w_count <= w_count + 1;
            end
            if (state == B2) begin
                if (w_count == 2) z <= 1'b1;
                else z <= 1'b0;
                w_count <= 2'd0; // Reset w_count after examination
            end
        end
    end
endmodule
