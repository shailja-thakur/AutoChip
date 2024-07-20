module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    localparam A = 2'b00;
    localparam B = 2'b01;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        z = 1'b0;
        
        case (state)
            A: begin
                if (s)
                    next_state = B;
            end
            B: begin
                if (cycle_count == 2'b10) begin
                    if (w_count == 2'b10)
                        z = 1'b1;
                    else
                        z = 1'b0;
                    
                    next_state = (reset ? A : B);
                end
            end
        endcase
    end

    // Counting logic
    always @(posedge clk) begin
        if (reset) begin
            w_count <= 2'b00;
            cycle_count <= 2'b00;
        end
        else if (state == B) begin
            cycle_count <= cycle_count + 1;
            if (w)
                w_count <= w_count + 1;

            if (cycle_count == 2'b10) begin
                cycle_count <= 2'b00;
                w_count <= 2'b00;
            end
        end
    end

endmodule
