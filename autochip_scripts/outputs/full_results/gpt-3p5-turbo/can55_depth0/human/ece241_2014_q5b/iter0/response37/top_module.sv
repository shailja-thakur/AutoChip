module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Define states
    parameter A = 2'b00;
    parameter B = 2'b01;

    // Define state and next state variables
    reg [1:0] state;
    reg [1:0] next_state;

    // Define outputs
    reg z_reg;

    // Synchronous state update
    always @(posedge clk) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Synchronous next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = B;
                end
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            A: begin
                z_reg = 1'b0;
            end
            B: begin
                z_reg = 1'b1;
            end
            default: z_reg = 1'b0;
        endcase
    end

    // Assign output
    assign z = z_reg;

endmodule
