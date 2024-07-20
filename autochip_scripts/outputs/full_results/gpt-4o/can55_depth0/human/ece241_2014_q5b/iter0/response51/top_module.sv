module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State declarations
    localparam A = 2'b01;
    localparam B = 2'b10;

    reg [1:0] state, next_state;
    reg z_reg;

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z_reg = 1;
                end else begin
                    next_state = A;
                    z_reg = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z_reg = 0;
                end else begin
                    next_state = B;
                    z_reg = 1;
                end
            end
            default: begin
                next_state = A;
                z_reg = 0;
            end
        endcase
    end

    // Output logic
    assign z = z_reg;
endmodule
