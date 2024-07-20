module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);
    
    reg [5:0] next_state;
    
    always @(posedge w) begin
        case(y)
            6'b000001: next_state = 6'b000010; // A --> B
            6'b000010: next_state = 6'b000001; // B --> A
            6'b000100: next_state = 6'b010000; // C --> E
            6'b001000: next_state = 6'b100000; // D --> F
            6'b010000: next_state = 6'b000100; // E --> C
            6'b100000: next_state = 6'b001000; // F --> D
            default: next_state = 6'b000000;
        endcase
    end
    
    always @* begin
        case(next_state)
            6'b000001: begin // A
                Y1 = 0;
                Y3 = 0;
            end
            6'b000010: begin // B
                Y1 = 1;
                Y3 = 0;
            end
            6'b000100: begin // C
                Y1 = 0;
                Y3 = 1;
            end
            6'b001000: begin // D
                Y1 = 1;
                Y3 = 1;
            end
            6'b010000: begin // E
                Y1 = 0;
                Y3 = 1;
            end
            6'b100000: begin // F
                Y1 = 1;
                Y3 = 0;
            end
            default: begin
                Y1 = 0;
                Y3 = 0;
            end
        endcase
    end
    
endmodule
