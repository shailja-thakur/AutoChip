module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    
    // Define state enum
    typedef enum logic [1:0] {
        OFF,
        ON
    } state;

    // State and next state registers
    reg state current_state;
    reg state next_state;

    // Output register
    reg out_reg;

    // Separate process for synchronous logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            current_state <= OFF;
        end else begin
            // State transition and output logic
            current_state <= next_state;
            out_reg <= (current_state == ON) ? 1'b1 : 1'b0;
        end
    end

    // Combinational logic for next state calculation
    always @* begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
        endcase
    end
    
    // Output assignment
    assign out = out_reg;

endmodule
