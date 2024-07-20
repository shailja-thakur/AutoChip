module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define the states
    localparam [1:0] OFF = 2'b00;
    localparam [1:0] ON = 2'b01;

    // Define the state register and next state logic
    reg [1:0] state, next_state;
    always @(posedge clk, negedge areset)
    begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Define the output logic
    always @(state, j, k)
    begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'bx;
        endcase
    end

    // Define the next state logic
    always @(state, j, k)
    begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end
endmodule
