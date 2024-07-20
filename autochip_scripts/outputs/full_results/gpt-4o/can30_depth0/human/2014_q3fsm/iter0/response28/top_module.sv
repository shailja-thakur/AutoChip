module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    reg [1:0] count;

    // State encoding
    localparam A = 3'b000, B = 3'b001, B1 = 3'b010, B2 = 3'b011, B3 = 3'b100;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                next_state = B3;
            end
            B3: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic and counter
    always @(posedge clk) begin
        if (reset) begin
            z <= 0;
            count <= 0;
        end
        else if (state == B1 || state == B2 || state == B3) begin
            if (w)
                count <= count + 1;
            if (state == B3) begin
                if (count == 2)
                    z <= 1;
                else
                    z <= 0;
                count <= 0;
            end
        end
    end

endmodule
