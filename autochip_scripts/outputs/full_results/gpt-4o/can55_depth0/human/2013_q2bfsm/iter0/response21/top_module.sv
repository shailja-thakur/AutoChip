module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] y_counter;
    
    // State encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;

    // State transition
    always @ (posedge clk or negedge resetn) begin
        if(!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @ (*) begin
        next_state = state;
        f = 0;
        g = 0;
        
        case (state)
            A: begin
                if(!resetn) begin
                    next_state = A;
                    f = 0;
                    g = 0;
                end else begin
                    next_state = B;
                    f = 1; // Output f set to 1 for one clock cycle
                end
            end
            
            B: begin
                next_state = C;
            end

            C: begin
                if(x) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            
            D: begin
                if(!x) begin
                    next_state = E;
                end else begin
                    next_state = C;
                end
            end
            
            E: begin
                g = 1; // Set g to 1 if x has produced the values 1, 0, 1
                if(y) begin
                    g = 1; // Maintain g = 1 permanently if y becomes 1 within 2 clock cycles
                    next_state = E;
                end else if (y_counter == 2'b01) begin
                    g = 0; // Set g = 0 permanently if y does not become 1 within 2 clock cycles
                    next_state = E;
                end else begin
                    y_counter = y_counter + 1;
                    next_state = E;
                end
            end
            
            default: next_state = A;
        endcase
    end
endmodule
