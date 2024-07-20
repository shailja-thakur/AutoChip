module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    reg [1:0] w_counter;
    reg count_enable;

    // State encoding
    localparam A = 3'b000;
    localparam B1 = 3'b001;
    localparam B2 = 3'b010;
    localparam B3 = 3'b011;
    localparam SET_Z = 3'b100;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        count_enable = 1'b0;
        case (state)
            A: begin
                z = 0;
                if (s)
                    next_state = B1;
            end
            B1: begin
                z = 0;
                count_enable = 1'b1;
                next_state = B2;
            end
            B2: begin
                z = 0;
                count_enable = 1'b1;
                next_state = B3;
            end
            B3: begin
                z = 0;
                count_enable = 1'b1;
                if (w_counter == 2)
                    next_state = SET_Z;
                else
                    next_state = B1;
            end
            SET_Z: begin
                z = 1;
                next_state = B1;
            end
        endcase
    end

    // w counter logic
    always @(posedge clk) begin
        if (reset || (state == A) || (state == SET_Z)) begin
            w_counter <= 0;
        end else if (count_enable) begin
            if (w)
                w_counter <= w_counter + 1;
        end
    end

endmodule
