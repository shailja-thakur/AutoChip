module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [1:0] state, next_state;
    reg [1:0] count;

    // States
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10; // State to count w cycles

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (!s)
                    next_state = A;
                else
                    next_state = C;
            end
            C: begin
                if (count == 2'b11) // after 3 clock cycles return to B
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // Output and Count Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
            count <= 2'b00;
        end else if (state == A) begin
            z <= 0;
            count <= 2'b00;
        end else if (state == C) begin
            if (count == 2'b11) begin
                z <= (count == 2'b11) ? 1 : 0;
                count <= 2'b00;
            end else begin
                if (w)
                    count <= count + 1'b1;
                else
                    count <= count;
            end
        end else begin
            z <= 0;
            count <= 2'b00;
        end
    end
endmodule
