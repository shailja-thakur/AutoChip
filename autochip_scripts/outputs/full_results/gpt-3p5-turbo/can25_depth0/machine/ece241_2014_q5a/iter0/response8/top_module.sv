module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Parameter declarations
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b01;

    // State register declaration
    reg [1:0] state;

    // Output wire declaration
    wire output_wire;

    // Always block triggered on positive edge of clock and reset signal
    always @(posedge clk or posedge areset)
    begin
        // If reset signal is triggered, set state to A
        if (areset)
        begin
            state <= A;
        end
        else // Case statement for determining state
        case (state)
            A: begin
                if (x) // If x is true, set state to C
                    state <= C;
                else // If x is false, stay at state A
                    state <= A;
            end
            B: begin
                if (x) // If x is true, stay at state B
                    state <= B;
                else // If x is false, set state to C
                    state <= C;
            end
            C: begin
                if (x) // If x is true, set state to B
                    state <= B;
                else // If x is false, stay at state C
                    state <= C;
            end
            default: state <= A; // Default case, set state to A
        endcase
    end

    // Output assignment based on state
    assign output_wire = (state == C);

    // Assigning output wire to output port z
    assign z = output_wire;

endmodule
