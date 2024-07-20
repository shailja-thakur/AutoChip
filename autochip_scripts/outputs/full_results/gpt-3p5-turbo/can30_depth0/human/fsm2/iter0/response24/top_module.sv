module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    wire out_temp;

    parameter OFF = 2'b00;
    parameter ON = 2'b01;

    // Synchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else begin
            case (state)
                OFF: begin
                    if (j)
                        state <= ON;
                    else
                        state <= OFF;
                end

                ON: begin
                    if (k)
                        state <= OFF;
                    else
                        state <= ON;
                end
            endcase
        end
    end

    // Output logic
    always @(state) begin
        case (state)
            OFF: out_temp = 1'b0;
            ON: out_temp = 1'b1;
        endcase
    end

    assign out = out_temp;

endmodule
