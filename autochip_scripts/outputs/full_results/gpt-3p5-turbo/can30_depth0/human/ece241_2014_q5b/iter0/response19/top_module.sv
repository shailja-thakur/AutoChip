module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    reg z_next;

    // State value assignments
    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= z_next;
    end

    always @* begin
        case (state)
            A: begin
                if (x)
                    z_next = 1'b1;
                else
                    z_next = 1'b0;
            end

            B: begin
                if (x)
                    z_next = 1'b0;
                else
                    z_next = 1'b1;
            end
        endcase
    end

    assign z = z_next;

endmodule
