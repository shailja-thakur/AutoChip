module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state, next_state;
    wire z_output;

    // Define states
    localparam A = 2'b00;
    localparam B = 2'b01;

    // Define transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                z_output = (x) ? 1'b1 : 1'b0;
            end
            B: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = B;
                end
                z_output = (x) ? 1'b0 : 1'b1;
            end
            default: // Should not happen
                next_state = A;
                z_output = 1'b0;
        endcase
    end

    // Register output
    reg z_output_reg;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z_output_reg <= 1'b0;
        end else begin
            z_output_reg <= z_output;
        end
    end

    // Assign output
    assign z = z_output_reg;

endmodule
