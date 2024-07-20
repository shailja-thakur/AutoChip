module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define the states
    parameter OFF = 0;
    parameter ON = 1;
    
    // Define the internal state and output registers
    reg [1:0] state;
    reg out_reg;
    
    // Sequential logic for state and output update
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
                default: state <= OFF;
            endcase
        end
    end
    
    // Combinational logic for output assignment
    always @(state) begin
        case (state)
            OFF: out_reg = 1'b0;
            ON: out_reg = 1'b1;
            default: out_reg = 1'b0;
        endcase
    end
    
    // Assign registered output to output port
    assign out = out_reg;

endmodule
