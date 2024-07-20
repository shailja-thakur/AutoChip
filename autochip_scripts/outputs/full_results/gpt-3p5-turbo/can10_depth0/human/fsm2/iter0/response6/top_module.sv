module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    // Synchronous always block for state updates
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b0;
        else begin
            case (state)
                2'b00: begin
                    if (j)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end
                2'b01: begin
                    if (k)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                end
                default: state <= 2'b00;
            endcase
        end
    end

    // Combinational logic for output generation
    always @(state) begin
        case (state)
            2'b00: out_reg = 1'b0;
            2'b01: out_reg = 1'b1;
            default: out_reg = 1'b0;
        endcase
    end

    assign out = out_reg;

endmodule
